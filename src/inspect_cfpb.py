import zipfile
import pandas as pd

archive = "data/raw/cfpb_complaints_full.zip"

with zipfile.ZipFile(archive) as z:
    with z.open("complaints.csv") as f:
        df = pd.read_csv(f, nrows=5)

print("\nCOLUMN NAMES:")
for col in df.columns:
    print("-", col)

print("\nSAMPLE DATA:")
print(df.head().to_string())

print("\nDATA TYPES:")
print(df.dtypes)
