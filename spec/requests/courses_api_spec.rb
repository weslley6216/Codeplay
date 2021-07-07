require 'rails_helper'

describe 'Courses API' do
  context 'GET /api/v1/courses' do
    it 'should get courses' do
      instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                      email: 'guanabara@codeplay.com')

      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                     code: 'RUBYBASIC', price: 10,
                     enrollment_deadline: '22/12/2033', instructor: instructor)
      Course.create!(name: 'Ruby on Rails',
                     description: 'Um curso de Ruby on Rails',
                     code: 'RUBYONRAILS', price: 20,
                     enrollment_deadline: '20/12/2033', instructor: instructor)

      get '/api/v1/courses'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(Course.count)
      expect(parsed_body[0]['name']).to eq('Ruby')
      expect(parsed_body[1]['name']).to eq('Ruby on Rails')
    end

    it 'returns no course' do
      get '/api/v1/courses'

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body).to be_empty
    end
  end
end
