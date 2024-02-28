require 'net/http'
require 'net/https'

class EmployeesService
  BASE_URL = 'https://dummy-employees-api-8bad748cda19.herokuapp.com/employees'.freeze

  def initialize(params = {})
    @params = params
  end

  def index(page)
    url = page.present? ? (BASE_URL+"?page=#{page}") : BASE_URL
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def get_employee(id)
    uri = URI("#{BASE_URL}/#{id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def create(employee_params)
    uri = URI(BASE_URL)
    post_or_put_request(uri, employee_params, 'Post')
  end

  def update(id, employee_params)
    uri = URI("#{BASE_URL}/#{id}")
    post_or_put_request(uri, employee_params, 'Put')
  end

  private

  def post_or_put_request(uri, employee_params, method)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    request = "Net::HTTP::#{method}".constantize.new(uri.path)
    request['Content-Type'] = 'application/json'
    request.body = employee_params.to_json
    response = http.request(request)
    JSON.parse(response.body)
  end
end
