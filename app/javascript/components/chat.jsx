import React, { PureComponent } from 'react';
import {ActionCableProvider, ActionCable} from 'react-actioncable-provider';

export class Chat extends PureComponent {
  constructor(props){
    super(props);
    this.toggleChatWindow = this.toggleChatWindow.bind(this);
    this.state = {
      chatWindow: false,
      messages: [],
    }
  }

  onReceived (message) {
    this.setState({
      messages: [
        ...this.state.messages,
        message
      ]
    })
  }

  sendMessage = () => {
    const message = this.refs.newMessage.value
    // Call perform or send
    this.refs.roomChannel.send({message: message, room: 3})
  }

  toggleChatWindow() {
    this.setState({ chatWindow: !this.state.chatWindow });
  }

  render() {
    const { chatWindow, messages } = this.state;
    return (
      <ActionCableProvider>
        <ActionCable ref='roomChannel' channel={{channel: 'MessagesChannel', room: '3'}} onReceived={this.onReceived} />
        <div className='chat-area'>
          { chatWindow &&
            <div className='chat-window'>
            <ul>
            {messages.map((message) =>
              <li key={message.id}>{message.body}</li>
            )}
            </ul>
            <input ref='newMessage' type='text' />
            <button onClick={this.sendMessage}>Send</button>
            </div>
          }
          <a className='chat-icon' onClick={this.toggleChatWindow}>💬</a>
        </div>
      </ActionCableProvider>
    );
  }
}