from fastapi import FastAPI

app = FastAPI(
    title="PayLink API",
    description="Backend System for Digital Wallet and Bill Payments",
    version="0.1.0"
)


@app.get("/health", tags=["Health"])
def health_check():
    return {"status": "healthy"}