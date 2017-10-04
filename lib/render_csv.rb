require 'csv'

module RenderCsv
  def to_csv(collection, colonnes, options = {col_sep: ';'})
    CSV.generate(options) do |csv|
      # Convertit les noms de colonnes en texte
      colonnes.map! {|col| col.to_s}
      csv << colonnes
      collection.all.each do |objet|
        csv << objet.attributes.values_at(*colonnes)
      end
    end
  end

end
