// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Guestbook
 * @notice A decentralized guestbook contract on LitVM where users can post messages with optional zkLTC tokens
 * @dev Implements message posting, retrieval, pagination, and owner withdrawal functionality
 */
contract Guestbook {
    /// @notice Structure to store message data
    struct Message {
        address sender;
        string text;
        uint256 timestamp;
        uint256 amount;
    }

    /// @notice Array storing all messages
    Message[] private messages;

    /// @notice Total number of messages posted
    uint256 public totalMessages;

    /// @notice Contract owner address
    address public owner;

    /// @notice Emitted when a new message is posted
    /// @param sender Address of the message sender
    /// @param text Content of the message
    /// @param timestamp Block timestamp when message was posted
    /// @param amount Amount of zkLTC sent with the message
    event MessagePosted(
        address indexed sender,
        string text,
        uint256 timestamp,
        uint256 amount
    );

    /// @notice Emitted when owner withdraws funds
    /// @param owner Address of the owner
    /// @param amount Amount withdrawn
    event Withdrawal(address indexed owner, uint256 amount);

    /// @notice Modifier to restrict function access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    /// @notice Contract constructor sets the deployer as owner
    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice Post a message to the guestbook without requiring tokens
     * @param _text The message text (max 280 characters recommended)
     */
    function postMessage(string calldata _text) external payable {
        require(bytes(_text).length > 0, "Message cannot be empty");
        require(bytes(_text).length <= 500, "Message too long");

        messages.push(Message({
            sender: msg.sender,
            text: _text,
            timestamp: block.timestamp,
            amount: msg.value
        }));

        totalMessages++;

        emit MessagePosted(msg.sender, _text, block.timestamp, msg.value);
    }

    /**
     * @notice Post a message to the guestbook with required tokens
     * @param _text The message text (max 280 characters recommended)
     */
    function postMessageWithToken(string calldata _text) external payable {
        require(bytes(_text).length > 0, "Message cannot be empty");
        require(bytes(_text).length <= 500, "Message too long");
        require(msg.value > 0, "Must send zkLTC tokens with message");

        messages.push(Message({
            sender: msg.sender,
            text: _text,
            timestamp: block.timestamp,
            amount: msg.value
        }));

        totalMessages++;

        emit MessagePosted(msg.sender, _text, block.timestamp, msg.value);
    }

    /**
     * @notice Get a specific message by index
     * @param _index Index of the message to retrieve
     * @return sender Address of the message sender
     * @return text Content of the message
     * @return timestamp Block timestamp when message was posted
     * @return amount Amount of zkLTC sent with the message
     */
    function getMessage(uint256 _index) 
        external 
        view 
        returns (
            address sender,
            string memory text,
            uint256 timestamp,
            uint256 amount
        ) 
    {
        require(_index < messages.length, "Message index out of bounds");
        Message memory message = messages[_index];
        return (message.sender, message.text, message.timestamp, message.amount);
    }

    /**
     * @notice Get the total number of messages
     * @return Total count of messages in the guestbook
     */
    function getMessageCount() external view returns (uint256) {
        return messages.length;
    }

    /**
     * @notice Get messages posted by a specific address with pagination
     * @param _user Address to search for
     * @param _limit Maximum number of messages to return
     * @param _offset Number of messages to skip
     * @return userMessages Array of messages from the specified user
     */
    function getMessagesByAddress(
        address _user,
        uint256 _limit,
        uint256 _offset
    ) external view returns (Message[] memory userMessages) {
        require(_limit > 0, "Limit must be greater than 0");
        require(_limit <= 100, "Limit too high");

        uint256 count = 0;
        for (uint256 i = 0; i < messages.length; i++) {
            if (messages[i].sender == _user) {
                count++;
            }
        }

        if (count == 0 || _offset >= count) {
            return new Message[](0);
        }

        uint256 resultSize = count - _offset;
        if (resultSize > _limit) {
            resultSize = _limit;
        }

        userMessages = new Message[](resultSize);
        uint256 userIndex = 0;
        uint256 skipped = 0;
        uint256 added = 0;

        for (uint256 i = messages.length; i > 0 && added < resultSize; i--) {
            if (messages[i - 1].sender == _user) {
                if (skipped >= _offset) {
                    userMessages[added] = messages[i - 1];
                    added++;
                } else {
                    skipped++;
                }
            }
        }

        return userMessages;
    }

    /**
     * @notice Get recent messages with pagination
     * @param _limit Maximum number of messages to return
     * @param _offset Number of messages to skip from the end
     * @return recentMessages Array of recent messages
     */
    function getRecentMessages(uint256 _limit, uint256 _offset) 
        external 
        view 
        returns (Message[] memory recentMessages) 
    {
        require(_limit > 0, "Limit must be greater than 0");
        require(_limit <= 100, "Limit too high");

        if (messages.length == 0 || _offset >= messages.length) {
            return new Message[](0);
        }

        uint256 resultSize = messages.length - _offset;
        if (resultSize > _limit) {
            resultSize = _limit;
        }

        recentMessages = new Message[](resultSize);

        for (uint256 i = 0; i < resultSize; i++) {
            recentMessages[i] = messages[messages.length - 1 - _offset - i];
        }

        return recentMessages;
    }

    /**
     * @notice Get the total amount of zkLTC sent to the contract
     * @return Total balance of the contract
     */
    function getTotalTokens() external view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @notice Withdraw all accumulated funds to owner
     * @dev Only callable by contract owner
     */
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Withdrawal failed");

        emit Withdrawal(owner, balance);
    }

    /**
     * @notice Transfer ownership to a new address
     * @param newOwner Address of the new owner
     */
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        owner = newOwner;
    }

    /**
     * @notice Fallback function to receive zkLTC
     */
    receive() external payable {}
}
