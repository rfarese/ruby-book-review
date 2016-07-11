class ReviewSeeder

  REVIEWS = [
    {
      book_id: 1,
      user_id: 2,
      title: "Review Seeder 1",
      description: "description for Review Seeder 1"
    },
    {
      book_id: 1,
      user_id: 2,
      title: "Review Seeder 2",
      description: "description for Review Seeder 2"
    },
    {
      book_id: 1,
      user_id: 2,
      title: "Review Seeder 3",
      description: "description for Review Seeder 3"
    },
    {
      book_id: 1,
      user_id: 3,
      title: "Review Seeder 4",
      description: "description for Review Seeder 4"
    },
    {
      book_id: 1,
      user_id: 3,
      title: "Review Seeder 5",
      description: "description for Review Seeder 5"
    },
    {
      book_id: 1,
      user_id: 3,
      title: "Review Seeder 6",
      description: "description for Review Seeder 6"
    },
    {
      book_id: 1,
      user_id: 4,
      title: "Review Seeder 7",
      description: "description for Review Seeder 7"
    },
    {
      book_id: 1,
      user_id: 4,
      title: "Review Seeder 8",
      description: "description for Review Seeder 8"
    },
    {
      book_id: 1,
      user_id: 4,
      title: "Review Seeder 9",
      description: "description for Review Seeder 9"
    },
    {
      book_id: 1,
      user_id: 5,
      title: "Review Seeder 10",
      description: "description for Review Seeder 10"
    },
    {
      book_id: 1,
      user_id: 5,
      title: "Review Seeder 11",
      description: "description for Review Seeder 11"
    },
    {
      book_id: 1,
      user_id: 5,
      title: "Review Seeder 12",
      description: "description for Review Seeder 12"
    },
    {
      book_id: 1,
      user_id: 6,
      title: "Review Seeder 13",
      description: "description for Review Seeder 13"
    },
    {
      book_id: 1,
      user_id: 6,
      title: "Review Seeder 14",
      description: "description for Review Seeder 14"
    },
    {
      book_id: 1,
      user_id: 6,
      title: "Review Seeder 15",
      description: "description for Review Seeder 15"
    },
    {
      book_id: 1,
      user_id: 7,
      title: "Review Seeder 16",
      description: "description for Review Seeder 16"
    },
    {
      book_id: 1,
      user_id: 7,
      title: "Review Seeder 17",
      description: "description for Review Seeder 17"
    },
    {
      book_id: 1,
      user_id: 7,
      title: "Review Seeder 18",
      description: "description for Review Seeder 18"
    },
    {
      book_id: 1,
      user_id: 8,
      title: "Review Seeder 19",
      description: "description for Review Seeder 19"
    },
    {
      book_id: 1,
      user_id: 8,
      title: "Review Seeder 20",
      description: "description for Review Seeder 20"
    },
    {
      book_id: 1,
      user_id: 8,
      title: "Review Seeder 21",
      description: "description for Review Seeder 21"
    }
  ]

  def self.seed!
    REVIEWS.each do |review_params|
      title = review_params[:title]
      review = Review.find_or_initialize_by(title: title)
      review.assign_attributes(review_params)
      review.save!
    end
  end
end
