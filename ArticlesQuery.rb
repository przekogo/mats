class ArticlesQuery
  attr_reader :relation

  def initialize(relation = Article.all)
    @relation = relation
  end

  def by_author_with_viewcount(view_count, first_name)
    by_author_with_viewcount_query
  end

  private

  def by_author_with_viewcount_query
    with_authors
      .where(published: true)
      .where('view_count > ?', view_count)
      .where('users.first_name LIKE ?', "#{first_name}%")
  end

  def with_authors
    relation.joins('LEFT OUTER JOIN users ON users.id = articles.author_id')
  end
end
