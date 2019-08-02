service Service {
    Transaction send_transaction(1: Transaction tx)
}

struct Transaction {
    1: binary address,
    2: i8 type,
    3: i64 timestamp,
    4: Data data,
    5: binary previous_public_key,
    6: binary previous_signature,
    7: binary origin_signature,
    8: ValidationStamp validation_stamp,
    9: list<CrossValidationStamp> cross_validation_stamps,
}

struct Data {
    1: Ledgers ledgers,
}

struct Ledgers {
    1: UCOLedger uco,
}

struct UCOLedger {
    1: binary to,
    2: double amount,
}

struct ValidationStamp {
    1: binary proof_of_work,
    2: binary proof_of_integrity,
    3: LedgerOperations ledger_operations,
}

struct LedgerOperations {
    1: list<NodeMovement> node_movements,
}

struct NodeMovement {
    1: binary node_public_key,
    2: double fee,
    3: bool is_coordinator = false,
    4: bool is_welcome = false,
    5: bool is_data_giver = false,
    6: bool is_cross_validation = false
}

struct CrossValidationStamp {
    1: binary signature,
    2: binary public_key,
}