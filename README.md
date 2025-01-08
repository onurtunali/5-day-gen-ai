# Readme

Google's 5 day generative AI course notes and code practices, for syllabus [Kaggle](https://www.kaggle.com/learn-guide/5-day-genai). These are personal notes and might lack overall coherence to outside parties. 

# Setup

Run `make create_environment` to install virtual environment. Instead of Kaggle notebooks, we are using local ones. Therefore, `GOOGLE_API_KEY` environment variables needs to be added to `.env` file.

We are using [Amazon Products Dataset 2023](https://www.kaggle.com/datasets/asaniczka/amazon-products-dataset-2023-1-4m-products). Run `make kaggle` to automatically download data. You need kaggle api token in `~/.kaggle/kaggle.json` or you can just download zip file and extract into `data` directory.

```bash
# make help commands
clean               Clean compiled or byte files 
create_environment  Setup virtual environment, check conda 
db                  Build Docker image
dr                  Run Docker image
dbr                 Build and run Docker image
kaggle              Retrieve Kaggle dataset 
sync_data_from_s3   Download data from s3 bucket
sync_data_to_s3     Upload data to s3 bucket
sync_models_from_s3 Download models from s3 bucket 
sync_models_to_s3   Upload models from s3 bucket
```

# Whitepaper Links by Day

| Day | Whitepaper |
| :--- | :--- |
| Day 1 | [Foundational Large Language Models & Text Generation](https://drive.google.com/file/d/1mFvTxfuJg4VNutn9wBvH_URznLRkklb3/view)|
| | [Embeddings & Vector Stores](https://drive.google.com/file/d/1jkQ_s8z4TQy85cVKwymhs4w3fP9PZ4xm/view) | 
| Day 2 | [Embeddings & Vector Stores](https://drive.google.com/file/d/1jkQ_s8z4TQy85cVKwymhs4w3fP9PZ4xm/view) |
| Day 3 | [Agents](https://drive.google.com/file/d/1oEjiRCTbd54aSdB_eEe3UShxLBWK9xkt/view) | 
| Day 4 | [Solving Domain Specific Problems Using LLMs](https://drive.google.com/file/d/13QBB3Z-f337BlBgTjJXdlQDWlrGmYddV/view)| 
