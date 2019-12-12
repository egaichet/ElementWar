require 'readline'

class ConsoleService
  def write(*sentences)
    sentences.each{ |sentence| puts(sentence) }
  end

  def ask(choices)
    while input = Readline.readline('> ', true)
      break if choices.include?(input)
    end
    input
  end
end
