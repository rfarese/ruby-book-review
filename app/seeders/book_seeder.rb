class BookSeeder
  BOOKS = [
    {
      user_id: 1,
      title: "Black Coffee Ruby",
      author: "Coffee Author",
      description: "How black coffee can impact how well you write Ruby programs"
    },
    {
      user_id: 2,
      title: "Computer Ruby",
      author: "Computer Ruby Author",
      description: "Ruby runs on computers...didn't you know that?"
    },
    {
      user_id: 3,
      title: "Something About Ruby",
      author: "Some Author",
      description: "Just a book that describes somethings about Ruby"
    },
    {
      user_id: 4,
      title: "Mackinlater",
      author: "Mack Latersmith",
      description: "A book about how the author prefers to use Mac's later in his development process...?"
    },
    {
      user_id: 4,
      title: "Blue Green Red Ruby",
      author: "The different colors of Ruby",
      description: "Didn't you know that Ruby can be in different colors?"
    },
    {
      user_id: 3,
      title: "Rainbow Ruby",
      author: "Johnny Rainbow Smith",
      description: "Take a look, its in this book, its Ruby Rainbow!"
    },
    {
      user_id: 1,
      title: "Ruby with Tea",
      author: "Organic Ruby Tea",
      description: "How organic tea can impact how well you write Ruby programs"
    },
    {
      user_id: 8,
      title: "Physical Ruby",
      author: "Matthew Benchpress",
      description: "Learn Ruby while building out your pecks!"
    },
    {
      user_id: 1,
      title: "Healthy Ruby",
      author: "Dr. Ruby",
      description: "A story about becoming a Dr. and learning the Ruby language"
    },
    {
      user_id: 10,
      title: "Ruby Flowers",
      author: "Pure Flowers",
      description: "How to get Ruby programs to be as pretty as a rose"
    },
    {
      user_id: 11,
      title: "Butterfly Ruby",
      author: "Butterfly Wings",
      description: "How to get your Ruby programs to fly like a butterfly"
    },
    {
      user_id: 7,
      title: "Eagle Ruby",
      author: "Flying Eagles Rule",
      description: "Birds of prey and Ruby...you'll be surprised how related they actually are"
    },
    {
      user_id: 2,
      title: "Italian Ruby",
      author: "Ruby Sabriano",
      description: "You're gonna write Ruby like I tell ya to write Ruby...is dat ok whichya?"
    },
    {
      user_id: 1,
      title: "American Ruby",
      author: "American Political Software",
      description: "We need to understand that how people write Ruby is largely coorelated to social and environmental factors"
    },
    {
      user_id: 1,
      title: "Donald Trump Ruby",
      author: "Donald Trump",
      description: "We're gonna build a wall out of Ruby...and we're gonna make Python developers build it!"
    },
    {
      user_id: 1,
      title: "Hillary Ruby",
      author: "Hillary Clinton",
      description: "How to create emails with Ruby..."
    },
    {
      user_id: 7,
      title: "Mi Nina Ruby",
      author: "Mi Nina",
      description: "Every had Mi Nina tortilla chips?  Well Mi Nina Ruby is just as horrible."
    },
    {
      user_id: 5,
      title: "Rabbit Ruby",
      author: "Fuzzy Bunny Tail",
      description: "Ruby can be a hoping good time for all people that love fuzzy furry little bunnies"
    },
  ]

  def self.seed!
    BOOKS.each do |book_params|
      title = book_params[:title]
      book = Book.find_or_initialize_by(title: title)
      book.assign_attributes(book_params)
      book.save!
    end
  end
end
