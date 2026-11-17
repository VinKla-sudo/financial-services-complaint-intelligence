import requests

url = "https://www.consumerfinance.gov/data-research/consumer-complaints/search/api/v1/"

params = {
    "date_received_min": "2025-01-01",
    "date_received_max": "2025-01-15",
    "field": "all",
    "format": "csv",
    "no_aggs": "true",
    "size": 100000,
    "sort": "created_date_desc"
}

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/131.0.0.0 Safari/537.36",
    "Accept": "text/csv,*/*",
    "Referer": "https://www.consumerfinance.gov/data-research/consumer-complaints/"
}

response = requests.get(url, params=params, headers=headers, timeout=120)

print("HTTP status:", response.status_code)
print("Content type:", response.headers.get("Content-Type"))
print("Response size:", len(response.content))
print("Response preview:", response.text[:300])

if response.status_code == 200 and "csv" in response.headers.get("Content-Type", "").lower():
    with open("data/raw/cfpb_complaints.csv", "wb") as f:
        f.write(response.content)
    print("SUCCESS: Dataset downloaded.")
else:
    print("Download unsuccessful. No file saved.")
