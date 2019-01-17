  require 'rubocop'
  require 'pry'
  require 'rspec'
  require 'nokogiri'
  require 'open-uri'
  require "i18n"
  I18n.config.available_locales = :fr

  #--------------------------------------------
#scrapping de crypto


A=[] # tableau de hashes
B=[] #tableau des noms
C=[] #tableau des prix

def crypto_scrapper ()
  # puts "\n\n\n\n\n\n\n\n Array de crypto  \n\n\n\n\n\n\n\n"
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  page.xpath("//td[2]/a").each do |node|
    B << node.text
    end
  page.xpath("//td[5]/a").each do |node|
    C << node.text.delete("$").to_f
  end

#creation du Array de Hashes
B.zip(C).each{|x| A << {x[0] => x[1]}}
# puts A.to_s
return A
end

crypto_scrapper

#------------------------------------------------
#scrapping de mails du Val d'Oise

D=[]

    def get_townhall_email(townhall_url)
      page = Nokogiri::HTML(open(townhall_url))
      page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node|
        return node.text
        end
      end


    def get_townhall_urls ()
      page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
        page.xpath("//tr[2]//p/a").each do |node|
          name = node.text
          email = get_townhall_email("http://annuaire-des-mairies.com/"+node["href"])
          D << {name => email}
          end
          # puts D.to_s
          return D
      end

def cityhall_scrapper ()
  # puts "\n\n\n\n\n\n\n\n Array de mairies  \n\n\n\n\n\n\n\n"
  get_townhall_urls
end

cityhall_scrapper
#------------------------------------------------
#scrapping de députés

E=[]
def deputee_scrapper ()
  # puts "\n\n\n\n\n\n\n\n Array de deputee  \n\n\n\n\n\n\n\n"
page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
  page.xpath("//tbody/tr/td[1]/a").each do |node|
    #on va chercher les prénoms
    first_name=node.text.split(" ")[1]
    #on va chercher les noms
    last_name=node.text.split(" ")[2]
    #construction de l'email en enlevant les accents etc sur le modèle trouvé sur internet
    email=I18n.transliterate(first_name, :locale => :fr).downcase+"."+I18n.transliterate(last_name, :locale => :fr).downcase+"@assemblee-nationale.fr"
    E << {"first_name" => first_name, "last_name" => last_name, "email" => email }
  end
  # puts E.to_s
  return E

end

deputee_scrapper
