# StackVault

A Clarity smart contract for STX staking and yield distribution on the Stacks blockchain.

## Overview

StackVault is a simple staking contract that allows users to:
- Deposit STX tokens (minimum 1 STX)
- Receive yield distributions from the admin
- Claim rewards 

## Functions

### User Functions

- `deposit()`: Deposit STX tokens (minimum 1 STX required)
- `claim-reward()`: Claim any available rewards

### Admin Functions 

- `add-yield()`: Admin-only function to add yield for distribution

## Contract Details

The contract maintains:
- A mapping of user deposits
- Total deposits tracking
- Pending rewards for users
- Admin privileges for yield distribution

