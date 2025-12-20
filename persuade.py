import csv 
import pandas as pd


def read_csv(file_path):
    """Reads a CSV file and returns its content as a list of dictionaries."""
    with open(file_path, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        return [row for row in reader]
    
data_path = "data/persuade_train_srctexts.csv"
persuade = read_csv(data_path)

persuade_df = pd.DataFrame(persuade)
persuade_df['discourse_type'].head(5)  # Display the first 5 source texts


discourse_distribution = persuade_df['discourse_type'].value_counts()
unannotated_row = persuade_df[persuade_df['discourse_type'] == 'Unannotated']
annotated_row = persuade_df[persuade_df['discourse_type'] != 'Unannotated']


annotated_distribution = annotated_row['discourse_type'].value_counts()


# create new column from each discourse type values of each row, annotate 0 or 1 base on whether that row has that discourse type
for discourse_type in annotated_distribution.index:
    column_name = discourse_type.lower().replace(" ", "_")
    annotated_row[column_name] = (annotated_row['discourse_type'] == discourse_type).astype(int)   


# drop some columns not needed
columns_to_drop = ['hierarchical_id', 'discourse_type_num','hierarchical_text','assignment', 'hierarchical_label', 'discourse_effectiveness', 'grade_level','source_text_1','source_text_2','source_text_3','source_text_4', 'discourse_start', 'discourse_end', 'discourse_type']
for col in columns_to_drop:
    if col in annotated_row.columns:
        annotated_row = annotated_row.drop(columns=[col])


annotated_row.to_csv("data/persuade_for_ena.csv", index=False)
