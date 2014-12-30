Facter.add(:vimversion) do
  setcode do
    `vim --version`.lines.first.gsub(/\(.*\)/, '').gsub(/[^0-9.]/, '')
  end
end
