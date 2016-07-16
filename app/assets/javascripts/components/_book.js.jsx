var Book = React.createClass({
  getInitialState() {
    return { book: [] };
  },

  componentDidMount() {
    $.getJSON('/api/v1/books/book.id', (response) => { this.setState({ book: response }) });
  },

  render() {
    return (
      <ul>
        <li>Title: {this.props.book.title}</li>
        <li>Author: {this.props.book.author}</li>
        <li>Description: {this.props.book.description}</li>
      </ul>
    )
  }
});
