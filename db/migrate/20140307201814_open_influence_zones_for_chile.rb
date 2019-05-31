class OpenInfluenceZonesForChile < ActiveRecord::Migration[5.2]
  def up
    chile = Country.find_by_iso_code("CL")
    InfluenceZone.where(:country_id => chile).destroy_all

    InfluenceZone.create!( zone_name: 'Santiago Metropolitana', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Tarapaca', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Antofagasta', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Atacama', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Coquimbo', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Valparaiso', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Libertador General Bernardo O Higgins', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Maule', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Bio Bio', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'La Araucania', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Los Lagos', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Aysen del General Carlos Ibanez del Campo', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Magallanes y la Antartica Chilena', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Los Rios', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
    InfluenceZone.create!( zone_name: 'Arica y Parinacota', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
  end

  def down
    chile = Country.find_by_iso_code("CL")
    InfluenceZone.where(:country_id => chile).destroy_all
    InfluenceZone.create!( zone_name: '', tag_name: 'ZI-AMS-CL (Chile)', country: Country.find_by_iso_code( 'CL' ) )
  end
end
