Example:

```ruby
class Banana
  def eat
    @eaten = true
  end

  def peel
    if @eaten
      true
    else
      false
    end
  end
end

# describe
#   1. subject
#   2. operation
#   3. all the its

#   it
#     1. what subject's operation achieves/does/results in.
#     2. the test itself

RSpec.describe(Banana, '.new') do
  it "creates a banana with no peel" do
    # Setup/Exercise
    banana = Banana.new

    # Verify
    expect(banana.peel).to(eq(true))

    # Teardown
  end
end

RSpec.describe(Banana, '#eat') do
  it "creates a peel" do
    # Setup
    banana = Banana.new

    # Exercise
    banana.eat

    # Verify
    expect(banana.peel).to(eq(nil))

    # Teardown
  end
end
```