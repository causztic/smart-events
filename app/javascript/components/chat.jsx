import React, { PureComponent } from 'react';
import {ActionCableProvider, ActionCable} from 'react-actioncable-provider';
import axios from 'axios';

export class ChatChannel extends PureComponent {
  constructor(props){
    super(props);
    this.onReceived = this.onReceived.bind(this);
    this.checkEnter = this.checkEnter.bind(this);
    this.state = {
      messages: []
    }
  }

  componentDidMount(){
    axios.get(`/chat_rooms/${this.props.room}/messages.json`)
    .then(res => {
      const messages = res.data.results;
      this.setState({ messages: [
        ...messages,
        ...this.state.messages,
      ] });
      this.el.scrollIntoView({ behavior: 'smooth' });
    });
  }

  componentDidUpdate(){
    this.el.scrollIntoView({ behavior: 'smooth' });
  }

  checkEnter (key) {
    if (key.key === 'Enter') {
      this.sendMessage();
    }
  }

  onReceived (message) {
    this.setState({
      messages: [
        ...this.state.messages,
        message.message
      ]
    })
    this.el.scrollIntoView({ behavior: 'smooth' });
  }

  sendMessage = () => {
    const message = this.refs.newMessage.value
    // Call perform or send
    if (message.length > 0){
      this.refs.roomChannel.send({message: message, room: this.props.room})
      this.refs.newMessage.value = '';
    }
  }

  render() {
    const { messages } = this.state;
    return (
    <div>
      <ActionCable ref='roomChannel' channel={{channel: 'MessagesChannel', room: this.props.room}} onReceived={this.onReceived} />
      <ul className='messages'>
        {messages.map((message) =>
          <li key={message.id} className={message.user_id === this.props.user_id ? 'self-message' : ''}>
            <span>{message.content}</span>
          </li>
        )}
        <li ref={el => { this.el = el; }} />
      </ul>
      <input ref='newMessage' type='text' onKeyPress={this.checkEnter}/>
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
              {this.props.chat_room_ids.map((id) =>  <ChatChannel key={id} room={id} user_id={this.props.user_id}/>)}
            </div>
          }
          <a className='chat-icon' onClick={this.toggleChatWindow}>💬</a>
        </div>
      </ActionCableProvider>
    );
  }
}