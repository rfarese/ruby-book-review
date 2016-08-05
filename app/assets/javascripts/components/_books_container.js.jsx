var BooksContainer = React.createClass({
  componentWillMount(){
    this.fetchBooks();
    setInterval(this.fetchBooks, 5000);
  },

  fetchBooks() {
    $.getJSON('/api/v1/books', (response) => { this.setState({ books: response }) });
  },

  getInitialState() {
    return { books: [] };
  },

  render(){
    return <Books books={this.state.books} />;
  }
});
