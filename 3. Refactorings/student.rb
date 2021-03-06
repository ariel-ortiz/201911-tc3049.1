class Student

  GOOD_GRADE = 85
  POVERTY_LIMIT = 15_000

  attr_reader :name, :id, :anual_income

  def initialize(name:, id:, anual_income:)
    @name = name
    @id = id
    @anual_income = anual_income
    @grades = []
  end

  def add_grade(grade)
    @grades << grade
    self
  end

  def display_information
    display_personal_information
    display_disclaimer
  end

  def scholarship_worthy?
    # Nothing reasonable to do if this student has currently no grades.
    no_grades_added = @grades.empty?
    raise "Can't compute average when we have no grades." if no_grades_added

    has_good_geades = average >= GOOD_GRADE
    is_poor = @anual_income < POVERTY_LIMIT
    has_good_geades and is_poor
  end

  private

  def average
    @grades.sum / @grades.size.to_f
  end

  def display_personal_information
    puts "Name: #{ @name } ID: #{ @id }"
    puts "Anual income: #{ @anual_income }"
    puts "Grade average: #{ average }"
  end

  def display_disclaimer
    puts 'The contents of this class must not be considered an offer,'
    puts 'proposal, understanding or agreement unless it is confirmed'
    puts 'in a document signed by at least five blood-sucking lawyers.'
  end

end