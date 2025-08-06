from fastapi import FastAPI, Request
import openai, os

app = FastAPI()

@app.post("/slack/events")
async def slack_events(req: Request):
    payload = await req.json()
    # Handle Slack event (e.g. /deploy)
    return {"text": "Event received"}

openai.api_key = os.getenv("OPENAI_API_KEY")
