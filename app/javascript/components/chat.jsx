import React, { PureComponent } from 'react';
import {ActionCableProvider, ActionCable} from 'react-actioncable-provider';

export class ChatChannel extends PureComponent {
  constructor(props){
    super(props);
    this.onReceived = this.onReceived.bind(this);
    this.state = {
      messages: []
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
    this.refs.roomChannel.send({message: message, room: this.props.room})
  }

  render() {
    const { messages } = this.state;
    return (
    <div>
      <ActionCable ref='roomChannel' channel={{channel: 'MessagesChannel', room: this.props.room}} onReceived={this.onReceived} />
      <ul className='messages'>
        {messages.map((m) =>
          <li key={m.message.id}>{m.message.content}</li>
        )}
      </ul>
      <input ref='newMessage' type='text' />
      <button onClick={this.sendMessage}>></button>
    </div>
    )
  }
}

export class Chat extends PureComponent {
  constructor(props){
    super(props);
    this.toggleChatWindow = this.toggleChatWindow.bind(this);
    this.state = {
      chatWindow: false
    }
  }
  toggleChatWindow() {
    this.setState({ chatWindow: !this.state.chatWindow });
  }

  render() {
    const { chatWindow } = this.state;
    return (
      <ActionCableProvider>
        <div className='chat-area'>
          { chatWindow &&
            <div className='chat-window'>
              {this.props.chat_room_ids.map((id) =>  <ChatChannel key={id} room={id}/>)}
            </div>
          }
          <a className='chat-icon' onClick={this.toggleChatWindow}>💬</a>
        </div>
      </ActionCableProvider>
    );
  }
}