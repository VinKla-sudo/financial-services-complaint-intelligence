import zipfile
import pandas as pd
import json
from pathlib import Path
from datetime import datetime, timezone

# --------------------------------------------------
# Configuration
# --------------------------------------------------

ARCHIVE_PATH = Path("data/raw/cfpb_complaints_full.zip")
OUTPUT_PATH = Path("data/processed/cfpb_complaints_2025.csv")
METADATA_PATH = Path("data/processed/extraction_metadata.json")

CHUNK_SIZE = 100_000

START_DATE = "2025-01-01"
END_DATE = "2026-01-01"

SOURCE_URL = "https://files.consumerfinance.gov/ccdb/complaints.csv.zip"

# --------------------------------------------------
# Validation
# --------------------------------------------------

if not ARCHIVE_PATH.exists():
    raise FileNotFoundError(f"Archive not found: {ARCHIVE_PATH}")

OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

if OUTPUT_PATH.exists():
    OUTPUT_PATH.unlink()

columns = [
    "Date received",
    "Product",
    "Sub-product",
    "Issue",
    "Sub-issue",
    "Company public response",
    "Company",
    "State",
    "ZIP code",
    "Tags",
    "Submitted via",
    "Date sent to company",
    "Company response to consumer",
    "Timely response?",
    "Complaint ID"
]

total_rows_scanned = 0
total_rows_selected = 0
invalid_dates = 0
first_write = True

print("Starting CFPB 2025 extraction...")
print(f"Date range: {START_DATE} to 2025-12-31")
print(f"Chunk size: {CHUNK_SIZE:,}")

# --------------------------------------------------
# Read compressed CSV in chunks
# --------------------------------------------------

with zipfile.ZipFile(ARCHIVE_PATH, "r") as archive:

    with archive.open("complaints.csv") as csv_file:

        reader = pd.read_csv(
            csv_file,
            usecols=columns,
            dtype="string",
            chunksize=CHUNK_SIZE,
            low_memory=False
        )

        for chunk_number, chunk in enumerate(reader, start=1):

            total_rows_scanned += len(chunk)

            dates = pd.to_datetime(
                chunk["Date received"],
                format="%Y-%m-%d",
                errors="coerce"
            )

            invalid_dates += int(dates.isna().sum())

            mask = (
                (dates >= START_DATE) &
                (dates < END_DATE)
            )

            filtered = chunk.loc[mask].copy()

            if not filtered.empty:

                filtered.to_csv(
                    OUTPUT_PATH,
                    mode="w" if first_write else "a",
                    header=first_write,
                    index=False,
                    encoding="utf-8"
                )

                total_rows_selected += len(filtered)
                first_write = False

            print(
                f"Chunk {chunk_number}: "
                f"Scanned {total_rows_scanned:,} | "
                f"Selected {total_rows_selected:,}"
            )

# --------------------------------------------------
# Save extraction metadata
# --------------------------------------------------

if first_write:
    raise ValueError("No 2025 records found. Check source dates.")

metadata = {
    "project": "Financial Services Complaint Intelligence",
    "source": SOURCE_URL,
    "archive": str(ARCHIVE_PATH),
    "extraction_date_utc": datetime.now(timezone.utc).isoformat(),
    "date_received_start": START_DATE,
    "date_received_end_exclusive": END_DATE,
    "chunk_size": CHUNK_SIZE,
    "total_source_rows_scanned": total_rows_scanned,
    "total_2025_rows_extracted": total_rows_selected,
    "invalid_date_rows_encountered": invalid_dates,
    "selected_columns": columns
}

with open(METADATA_PATH, "w", encoding="utf-8") as f:
    json.dump(metadata, f, indent=4)

print("\nEXTRACTION COMPLETE")
print("-------------------")
print(f"Rows scanned: {total_rows_scanned:,}")
print(f"2025 records: {total_rows_selected:,}")
print(f"Invalid dates: {invalid_dates:,}")
print(f"Output: {OUTPUT_PATH}")
print(f"Metadata: {METADATA_PATH}")
