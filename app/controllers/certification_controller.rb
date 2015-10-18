class CertificationController < ApplicationController
  def index
    @certificates = Certificate.all
  end

  def background
    Thread.start { self.parse }
  end

  def parse
    a = Mechanize.new

    letters = ('A'..'Z')
    #for debugging purposes
    # results = [] 

    letters.each do |letter|

      a.get('https://certification.pmi.org/registry.aspx') do |page|
        search_result = page.form_with(:action => 'registry.aspx') do |search|    

          search['dph_RegistryContent$tbSearch'] = letter.to_s
          search['dph_RegistryContent$wcountry'] = 'RUS'
        end.submit

        table = search_result.at('table/tr[2]/td[1]/span/text()')

        #for debugging purposes
        # i = 0

        names = ""
        city = ""

        table = search_result.search('table/tr').each do |row|
            
          #for debugging purposes
          # i += 1

          cert = Certificate.new

          names = row.at('td[1]/span/text()').to_s == "" ?  names : row.at('td[1]/span/text()').to_s
              
          # names = row.at('td[1]/span/text()').to_s
          cert.last_name = names.split.last
          cert.first_name = names.split.first

          # cuts "Renat F Galiev" to first_name "Renat F" instead of "Renat"
          # cert.first_name = names[0...names.rindex(' ')]

          city = row.at('td[2]/span/text()').to_s == "" ? city : row.at('td[2]/span/text()').to_s
          cert.city = city
          # cert.city = row.at('td[2]/span/text()').to_s

          cert.credential = row.at('td[4]/span/text()').to_s
          cert.earned = row.at('td[5]/span/text()').to_s
          cert.status = row.at('td[6]/span/text()').to_s == "Active" ? :active : :retired

          previous_cert = cert

          cert.save if !Certificate.exists?(:last_name => cert.last_name, 
                                            :first_name => cert.first_name, 
                                            :city => cert.city, 
                                            :credential => cert.credential,
                                            :earned => cert.earned,
                                            :status => cert.status)
              
        end

        #for debugging purposes
        #puts letter.to_s + ' ' + i.to_s
      end
    end
  end
end
