import React, { PureComponent } from 'react';

export class Chat extends PureComponent {
  constructor(props){
    super(props);
    this.toggleChatWindow = this.toggleChatWindow.bind(this);
    this.state = {
      chatWindow: false,
      messages: [],
    }
  }

  toggleChatWindow() {
    this.setState({ chatWindow: !this.state.chatWindow });
  }

  render() {
    const { chatWindow } = this.state;
    return (
      <div className='chat-area'>
      { chatWindow &&
        <div className='chat-window'>
        </div>
      }
      <a className='chat-icon' onClick={this.toggleChatWindow}>💬</a>
      </div>
    );
  }
}