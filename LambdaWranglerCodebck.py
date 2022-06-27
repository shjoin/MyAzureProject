import awswrangler as wr


def lambda_handler(event, context):
    raw_s3_bucket = 'shjos3'
    raw_input_path_dir = 'input/'
    raw_path = f"s3://{raw_s3_bucket}/{raw_input_path_dir}"
    raw_output_path = 'output/'
    raw_write_path = f"s3://{raw_s3_bucket}/{raw_output_path}"
    csvdf = wr.s3.read_csv(path=raw_path, dataset=True)
    wr.s3.to_parquet(df=csvdf, dataset=True, path=raw_write_path)

    return {
        'statusCode': 200
    }
