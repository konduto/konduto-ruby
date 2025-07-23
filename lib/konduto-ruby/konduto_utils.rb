# frozen_string_literal: true

class KondutoUtils
  def self.array_to_hash(arr)
    arr.map { |pair| Hash[*pair] }
  end

  def self.remove_nil_keys_from_hash(hash)
    hash.delete_if { |_k, v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }
  end

  def self.deep_symbolize_keys(hash)
    if hash.is_a? Hash
      return hash.each_with_object({}) do |(k, v), memo|
               memo[k.to_sym] = deep_symbolize_keys(v)
             end
    end
    if hash.is_a? Array
      return hash.each_with_object([]) do |v, memo|
               memo << deep_symbolize_keys(v)
             end
    end

    hash
  end

  def self.parameterize_key(key)
    str = key.to_s
    str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase
  end
end
