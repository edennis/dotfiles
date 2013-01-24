if defined?(Rails) && Rails.production?
  conf = IRB.conf[:PROMPT][IRB.conf[:PROMPT_MODE]]
  red = "\033[0;31m"
  reset = "\033[0m"
  [:PROMPT_S, :PROMPT_C].each do |p|
    conf[p].gsub!(/^(.*)$/, "#{red}\\1#{reset}")
  end
  conf[:PROMPT_I] = "#{red}%N(%m):%03n:%i (PRODUCTION) > #{reset}"
end
