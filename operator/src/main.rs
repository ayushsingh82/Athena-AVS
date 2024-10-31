use ethers::prelude::*;
use ethers::contract::abigen;
use ethers::providers::{Provider, Http};
use ethers::signers::{LocalWallet, Signer};
use ethers::types::U256;
use serde::{Deserialize, Serialize};
use dotenv::dotenv;
use std::env;
use std::sync::Arc;
use tokio::time::{sleep, Duration};

// Define the structure of the task metadata (based on your Athena AVS TaskRegistry)
#[derive(Serialize, Deserialize, Debug)]
struct TaskMetadata {
    name: String,
    description: String,
    url: String,
    created_at: U256,
}

// Import the Athena contract's ABI using ethers-rs
abigen!(
    TaskRegistry,
    r#"[
        function isTask(bytes32 taskId) external view returns (bool)
        function getTaskMetadata(bytes32 taskId) external view returns (tuple(string, string, string, uint256))
    ]"#
);

// Operator struct to hold the client and contract instances
struct AthenaOperator {
    client: Arc<Provider<Http>>,
    contract: TaskRegistry<Provider<Http>>,
}

impl AthenaOperator {
    // Initializes a new AthenaOperator instance
    async fn new() -> Self {
        dotenv().ok();

        let provider_url = env::var("RPC_URL").expect("RPC_URL must be set");
        let provider = Provider::<Http>::try_from(provider_url).expect("Invalid provider URL");
        let client = Arc::new(provider);

        let contract_address = env::var("CONTRACT_ADDRESS")
            .expect("CONTRACT_ADDRESS must be set")
            .parse::<Address>()
            .expect("Invalid contract address");

        let contract = TaskRegistry::new(contract_address, client.clone());

        AthenaOperator { client, contract }
    }

    // Fetches task metadata and logs it
    async fn fetch_task_metadata(&self, task_id: H256) -> Result<TaskMetadata, Box<dyn std::error::Error>> {
        let metadata = self.contract.get_task_metadata(task_id).call().await?;
        Ok(TaskMetadata {
            name: metadata.0,
            description: metadata.1,
            url: metadata.2,
            created_at: metadata.3,
        })
    }

    // Main loop to poll tasks and handle them
    async fn run(&self) {
        loop {
            // Here, you would pull tasks from the TaskRegistry
            let task_id = H256::zero(); // Replace with actual task ID fetching
            if let Ok(metadata) = self.fetch_task_metadata(task_id).await {
                println!("Fetched task metadata: {:?}", metadata);

                // Execute task logic based on metadata here
                self.execute_task(&metadata).await;
            }

            // Sleep for a while before polling again
            sleep(Duration::from_secs(10)).await;
        }
    }

    // Placeholder function to execute a task based on metadata
    async fn execute_task(&self, metadata: &TaskMetadata) {
        println!("Executing task: {:?}", metadata.name);
        // Implement the logic for task execution here based on metadata information
    }
}

// Main function to run the operator
#[tokio::main]
async fn main() {
    let operator = AthenaOperator::new().await;
    operator.run().await;
}
