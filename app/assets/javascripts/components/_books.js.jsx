var Books = React.createClass({
  render() {

    var createBook = function(book){
      var link = "/books/" + book.id.toString();
      var book_id = "book_" + book.id.toString();
      return <li id={book_id}><a href={link}>{book.title}</a></li>;
    }

    return <ul>{this.props.books.map(createBook)}</ul>;
  }
})
