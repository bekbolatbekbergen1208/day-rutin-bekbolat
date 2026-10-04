'use client';
import {useState} from 'react';
import {BookOpen,Check,Plus,CalendarDays,ChevronRight} from 'lucide-react';
import {Data,Item,nextDate,today,planDay} from '@/lib/data';
import {Panel,Empty,ProgressBar} from './primitives';
type Props={data:Data;save:(collection:string,item:any,action?:string)=>Promise<boolean>;busy:boolean;add:(collection:string,extra?:any,item?:any)=>void;open:(collection:string,item:Item)=>void;go:(page:string)=>void;compact?:boolean};
export default function Tomorrow({data,save,busy,add,open,go,compact=false}:Props){
 const date=nextDate(today()),plan=planDay(data,date),records:Item[]=data.lessonPrep||[],done=plan.lessons.filter((l:Item)=>records.some(p=>p.lessonId===l.id&&p.date===date&&p.done)).length;
 const due=data.homework.filter((h:Item)=>h.status!=='Done'&&(h.due===date||plan.lessons.some((l:Item)=>l.title.toLocaleLowerCase()===String(h.subject).toLocaleLowerCase())));
 const events:Item[]=data.events.filter((e:Item)=>e.date===date).sort((a:Item,b:Item)=>String(a.start).localeCompare(String(b.start)));
 return <div className={compact?'tomorrow-compact':'tomorrow-workspace'}><Panel title="Ертеңгі сабаққа дайындал" tag={new Date(date+'T12:00:00+05:00').toLocaleDateString('kk-KZ',{weekday:'long',day:'numeric',month:'long'}).toUpperCase()} action={compact?<button className="text-btn" onClick={()=>go('Tomorrow')}>Ертең <ChevronRight size={15}/></button>:<BookOpen size={20}/>}>
 {plan.lessons.length>0?<><div className="row muted"><span>{done} / {plan.lessons.length} сабақ дайын</span><span>Ертең: {date}</span></div><ProgressBar value={done/plan.lessons.length*100}/><div className="prep-list">{plan.lessons.map((lesson:Item)=><LessonPreparation key={date+lesson.id} lesson={lesson} date={date} record={records.find(p=>p.lessonId===lesson.id&&p.date===date)} save={save} busy={busy} compact={compact}/>)}</div></>:<Empty text="Ертеңге сабақ кестесі енгізілмеген." action="Сабақ кестесін қосу" onClick={()=>go('School')}/>}
 </Panel>{!compact&&<><Panel title="Ертеңгі рутина" tag="ӨЗ КҮНІҢДІ ЖОСПАРЛА" action={<button className="outline" onClick={()=>add('events',{date})}><Plus size={15}/>Рутина қосу</button>}>
 <p className="muted">Уақытын және не істейтініңді жаз. Ертең бұл жоспар Today бөлімінде көрсетіледі.</p>{events.length?events.map(e=><button className="routine-row" key={e.id} onClick={()=>open('events',e)}><CalendarDays size={17}/><time>{e.start} — {e.end}</time><strong>{e.title}</strong><ChevronRight size={16}/></button>):<Empty text="Ертеңге жоспар әлі жоқ." action="Алғашқы рутина" onClick={()=>add('events',{date})}/>}
 </Panel><Panel title="Үй тапсырмасы" tag="ЕРТЕҢГІ САБАҚТАРМЕН БАЙЛАНЫСТЫ" action={<button className="text-btn" onClick={()=>add('homework',{due:date})}><Plus size={15}/>Қосу</button>}>
 {due.length?due.map((h:Item)=><div className="task-row" key={h.id}><button className="checkbox" disabled={busy} aria-label={`${h.subject}: орындалды`} onClick={()=>save('homework',{id:h.id,status:'Done'},'update')}/><button className="task-body" onClick={()=>open('homework',h)}><strong>{h.subject} · {h.title}</strong><small>{h.due}</small></button></div>):<p className="muted">Орындалмаған үй тапсырмасы жоқ.</p>}
 </Panel><p className="muted">«Оқыдым» тек осы күннің дайындығын белгілейді. Келесі күнге жаңа белгілер ашылады. Үй тапсырмасы бөлек белгіленеді.</p></>}</div>
}
function LessonPreparation({lesson,date,record,save,busy,compact}:{lesson:Item;date:string;record?:Item;save:Props['save'];busy:boolean;compact:boolean}){
 const [note,setNote]=useState<string|null>(null),[feedback,setFeedback]=useState('');const value=note??String(record?.note||'');
 async function persist(done:number){setFeedback('');if(await save('lessonPrep',{title:String(lesson.title),date,lessonId:lesson.id,done,note:value})){setNote(null);setFeedback('Сақталды');}}
 return <article className={`prep-lesson ${record?.done?'prepared':''}`}><div className="row"><div><span className="eyebrow">{lesson.start} — {lesson.end}</span><h3>{lesson.title}</h3></div><button className={record?.done?'outline':'primary'} disabled={busy} onClick={()=>persist(record?.done?0:1)} aria-pressed={!!record?.done}><Check size={15}/>{record?.done?'Оқыдым ✓':'Оқыдым'}</button></div>
 {!compact&&<form onSubmit={e=>{e.preventDefault();persist(Number(record?.done||0))}}><label>Не оқыдың? Қай тақырыпты қайталадың?<textarea maxLength={4000} value={value} onChange={e=>{setNote(e.target.value);setFeedback('')}} placeholder="Мысалы: тақырыпты оқыдым, есептерді шығардым…"/></label><div className="row"><span className="muted" role="status">{feedback}</span><button className="text-btn" disabled={busy||note===null}>Жазбаны сақтау</button></div></form>}
 {compact&&record?.note&&<p className="prep-note">{record.note}</p>}
 </article>
}
