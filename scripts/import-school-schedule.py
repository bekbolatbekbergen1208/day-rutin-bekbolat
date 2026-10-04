#!/usr/bin/env python3
"""Apply the timetable template to the local development workspace."""
import http.cookiejar
import json
from pathlib import Path
import urllib.request

ORIGIN = 'http://127.0.0.1:5173'

def main():
    path = Path(__file__).resolve().parent.parent / 'templates' / 'school-schedule.json'
    schedule = json.loads(path.read_text())
    jar = http.cookiejar.CookieJar()
    client = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(jar))
    with client.open(ORIGIN + '/signin-with-chatgpt?return_to=/') as response:
        response.read()

    def api(body=None):
        request = urllib.request.Request(
            ORIGIN + '/api/data',
            data=json.dumps(body, ensure_ascii=False).encode() if body else None,
            headers={'Content-Type': 'application/json'},
        )
        with client.open(request) as response:
            return json.load(response)

    existing = api()['lessons']
    for item in existing:
        if item['title'] == '9 ЭЛ Олимп М':
            api({'collection': 'lessons', 'action': 'delete', 'item': {'id': item['id']}})
    for lesson in schedule:
        match = next((item for item in existing if item['weekday'] == lesson['weekday']
                      and item['start'] == lesson['start']), None)
        values = dict(lesson)
        if match:
            values['id'] = match['id']
        api({'collection': 'lessons', 'action': 'update' if match else 'create', 'item': values})
    print(f'Applied {len(schedule)} lesson slots to the local workspace.')

if __name__ == '__main__':
    main()
