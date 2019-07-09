module API
  module V1
    class Base < Grape::API
      mount API::V1::Artists
      mount API::V1::Albums
      mount API::V1::Genres

      add_swagger_documentation(
        info: {
          title: 'Rubitify Service',
          description: 'A service to fetch data for your favorite bands',
          contact_name: 'Damian Galindo',
          contact_email: 'damiangalindomeza@gmail.com',
          contact_url: 'Contact URL',
          license: 'The name of the license.',
          license_url: 'www.The-URL-of-the-license.org'
        },
        hide_documentation_path: true,
        api_version: 'v1',
        base_path: '/api',
        hide_format: true
      )
    end
  end
end
