# PowerShell script

# Define your Solana RPC endpoint
$DEFAULT_RPC_URL = ""
# Define your Solana pubkey path
$DEFAULT_KEY = ""
# Define Solana gas fee
$DEFAULT_FEE = 
# Define how many CPU cores to use
$DEFAULT_CORES = 

# Set variables with defaults or override with arguments
$RPC_URL = if ($args.Count -gt 0) { $args[0] } else { $DEFAULT_RPC_URL }
$KEY = if ($args.Count -gt 1) { $args[1] } else { $DEFAULT_KEY }
$FEE = if ($args.Count -gt 2) { $args[2] } else { $DEFAULT_FEE }
$CORES = if ($args.Count -gt 3) { $args[3] } else { $DEFAULT_CORES }

# Construct the command string
$COMMAND = "ore --rpc $RPC_URL --keypair $KEY --priority-fee $FEE mine --cores $CORES"

# Infinite loop to keep trying the command
while ($true) {
    Write-Host "Starting the process..."
    Invoke-Expression $COMMAND
    if ($LASTEXITCODE -eq 0) { break }
    Write-Host "Restarting in 5 seconds..."
    Start-Sleep -Seconds 5
}

