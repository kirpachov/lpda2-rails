class Hash
  def dig!(*path)
    value = dig(*path)
    return value if value.present?

    raise "Required config missing: #{path.join(".")}"
  end
end
