import pandas as pd
df_master = pd.read_csv("employee_master.csv", delimiter=';')
df_data = pd.read_csv("empoyee_data.csv", delimiter=';')
df_rating = pd.read_csv("empoyee_rating.csv", delimiter=';')
df_industry = pd.read_csv("industry_compensation.csv", delimiter=';')
df_data.rename(columns={
    "id": "employee_id",
    "Role": "role",
    "Location": "location",
    "Years_of_Experience": "yoe"
}, inplace=True)
df_rating.rename(columns={
    "id": "employee_id",
    "YoE": "yoe",
    "Role": "role",
    "Location": "location",
    "L3Q_Average_Manager_Rating": "manager_rating"
}, inplace=True)
df_industry.rename(columns={
    "Role": "role",
    "Location": "location",
    "average_industry_comp_int": "industry_avg_comp"
}, inplace=True)
df = df_master.merge(df_data, on="employee_id", how="left")
df = df.merge(df_rating[["employee_id", "manager_rating"]], on="employee_id", how="left")
df = df.merge(df_industry, on=["role", "location"], how="left")
df['manager_rating'] = df['manager_rating_y']
df['average_industry_compensation'] = df['industry_avg_comp']
# Drop unused/duplicate columns
df.drop(columns=[
    'manager_rating_x',
    'manager_rating_y',
    'industry_avg_comp'
], inplace=True, errors='ignore')
df["current_compensation"] = pd.to_numeric(df["current_compensation"], errors="coerce")
df["average_industry_compensation"] = pd.to_numeric(df["average_industry_compensation"], errors="coerce")
df["manager_rating"] = pd.to_numeric(df["manager_rating"], errors="coerce").fillna(0)
# STEP 6: Define and apply rating-scaled increment logic
def simulate_increment_scaled_by_rating(df, base_pct=10):
    df = df.copy()
    df["rating_factor"] = df["manager_rating"] / 5
    df["effective_increment_pct"] = base_pct * df["rating_factor"]
    df["new_comp"] = df["current_compensation"] * (1 + df["effective_increment_pct"] / 100)
    return df
df_incremented = simulate_increment_scaled_by_rating(df, base_pct=10)
final = df_incremented[[
    "employee_id", "Name", "role", "location", "yoe",
    "current_compensation", "new_comp",
    "average_industry_compensation", "manager_rating", "active_status"
]]
final.to_csv("final_employee_data.csv", index=False)
