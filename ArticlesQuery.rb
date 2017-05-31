class ArticlesQuery
  attr_reader :relation

  def initialize(relation = Article.all)
    @relation = relation
  end

  def published
    relation.where(published: true)
  end

  def minimal_view_count(view_count)
    return relation unless view_count.present?
    relation.where('view_count > ?', view_count)
  end

  def author_first_name_like(first_name)
    return relation unless first_name.present?
    with_authors
      .where('users.first_name LIKE ?', "#{first_name}%")
  end

  private

  def with_authors
    relation.joins('LEFT OUTER JOIN users ON users.id = articles.author_id')
  end
end
