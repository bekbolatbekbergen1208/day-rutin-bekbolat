import { getChatGPTUser } from "@/app/chatgpt-auth";

export async function GET(request: Request) {
  const user = await getChatGPTUser();
  if (!user) {
    return new Response("BEKBOLAT OS sign in required", {
      status: 401,
      headers: {
        "WWW-Authenticate": 'Basic realm="BEKBOLAT OS", charset="UTF-8"',
        "Cache-Control": "no-store",
      },
    });
  }
  return Response.redirect(new URL("/", request.url), 302);
}
