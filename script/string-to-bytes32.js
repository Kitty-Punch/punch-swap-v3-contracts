// Convert a string to bytes32 format
const inputString = "PunchSwap V3";

// Create a buffer from the string
const buffer = Buffer.from(inputString, 'utf8');

// Pad the buffer to 32 bytes if needed
const paddedBuffer = Buffer.alloc(32);
buffer.copy(paddedBuffer);

// Convert to hex and add 0x prefix
const bytes32 = '0x' + paddedBuffer.toString('hex');

console.log('Original string:', inputString);
console.log('bytes32 value:', bytes32); 