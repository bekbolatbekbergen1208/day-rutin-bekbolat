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

  const url = new URL(request.url);
  const returnTo = url.searchParams.get("return_to");
  const safeReturnTo =
    returnTo && returnTo.startsWith("/") && !returnTo.startsWith("//")
      ? returnTo
      : "/";
  return Response.redirect(new URL(safeReturnTo, request.url), 302);
}
