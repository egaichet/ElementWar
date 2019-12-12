require_relative 'setup'

handler = GameHandler.random_minions_and_boss_anywhere
begin
  handler.start!
rescue Exit
  handler.bye!
end
