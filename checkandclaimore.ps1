# PowerShell script

# Define your RPC URL
$RPC_URL = "your_rpc_url_here"

# Function to check unclaimed Ore balance
function Check-OreBalance {
    Write-Host "Checking the unclaimed Ore balance..."
    $balanceOutput = ore --keypair "$HOME/.config/solana/id.json" rewards
    return $balanceOutput
}

# Function to claim Ore rewards
function Claim-OreRewards {
    Write-Host "Claiming Ore rewards..."
    ore --keypair "$HOME/.config/solana/id.json" --rpc $RPC_URL claim
}

# Function to extract the unclaimed Ore amount from the output
function Get-UnclaimedOreAmount {
    param (
        [string]$balanceOutput
    )

    # Assuming the balance output contains a line like "Unclaimed Ore: 0.5"
    # You may need to adjust the regex pattern based on the actual output format
    if ($balanceOutput -match "Unclaimed Ore:\s+([0-9]*\.?[0-9]+)") {
        return [float]$matches[1]
    } else {
        return 0
    }
}

# Main loop
while ($true) {
    # Check Ore balance
    $balance = Check-OreBalance
    
    # Extract the unclaimed Ore amount
    $unclaimedOre = Get-UnclaimedOreAmount -balanceOutput $balance

    # Check if the unclaimed Ore is between 0.1 and 1
    if ($unclaimedOre -ge 0.1 -and $unclaimedOre -le 1) {
        Claim-OreRewards
    } else {
        Write-Host "No unclaimed Ore rewards in the range of 0.1 to 1. Checking again in 15 minutes..."
    }
    
    # Add a delay of 15 minutes (900 seconds) before the next check
    Start-Sleep -Seconds 900
}

