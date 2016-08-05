var Books = React.createClass({
  render() {

    var createBook = function(book){
      var link = "/books/" + book.id.toString();
      var book_id = "book_" + book.id.toString();
      return <li id={book_id} className="column"><a href={link}>{book.title}</a></li>;
    }

    return <ul className="row small-up-1 medium-up-2 large-up-4">{this.props.books.map(createBook)}</ul>;
  }
})
