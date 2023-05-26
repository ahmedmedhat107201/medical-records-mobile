const String SEND_MESSAGE = """
  mutation sendMessage(\$value: String!, \$toId: String!) {
      sendMessage(data: { value: \$value, toId: \$toId }) {
        id
        roomId
        value
        type
        senderId
      }
  }
  """;
final String MESSAGE_RECIEVED = """
subscription messageSent{
  messageSent{
    id
    value
    senderId
    roomId
    createdAt
    sentUser{
      name
      id
      image_src
    }
  }
}
""";
