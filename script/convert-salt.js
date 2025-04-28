const salt = "0x464c4f5700000000000000000000000000000000000000000000000000000000";

// Remove the 0x prefix and convert to buffer
const buffer = Buffer.from(salt.slice(2), 'hex');

// Convert to string, removing null bytes
const stringValue = buffer.toString('utf8').replace(/\0/g, '');

console.log('Original bytes32:', salt);
console.log('String value:', stringValue); 