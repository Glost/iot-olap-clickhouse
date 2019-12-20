//
//  NetworkOperation.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 03/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


//Операция получения уведомлений
class NetworkOperation: Operation
{
	var resultBlock: ((NetworkResponse?)->Void)?
	var body: NetworkRequestBody
	
	init(body: NetworkRequestBody, resultBlock: ((NetworkResponse?) -> Void)?) {
		self.body = body
		super.init()
		self.resultBlock = resultBlock
	}
	
	override func main()
	{
		let token = """
AAABAB5t0TXsSUIWp33PPUVH9K6tk7rKcv9hc5TJiD0xn6x9kNGxOEFZv6Ek6TAap4uYB/q/wc3mdcCrpP1JyuYRdP8W3Y5PhzdLIMTL5Pf8Wpca0AJMHKuAtQdIcikfSRpM/typg+3YDvHzCy0Lk8QDPEQT9+3T4Ayopl17lrYf23jdtvhnNvCDGRmHWDmq6qN4XA7bzTmN6s6uAk17nZt7XHmtACO3aCzIr4oGwlkSaHWdgooaj9ouDVZjfRt63CsgwbIIO6mPkMQXCSmHAte8ULRKtU/1bsOsGQQWdLLDW3PvTOci7Xp0iQqsU/ae9tbMCrUS2320OQDPbaFfkGh6Pi0AAACBAO2E3sgYpACyxiht3t0PiKNxPxuWYv9Xvqu93WK/+FrGZA5qL1GScuK2fir/zbhQg3yY7Lo92W9nI1yWLPdGcMSCNGsURhzou4fytAlg48BoJ5LUJQ6KC2WqsVWJa++Okh3hlnl0/fqE1zcXRR9RlxiOL0e7pzHSzxet064iuIrhAAAAgQDKPueL4rmhtVIL7Tu1RZesfZk2m315BZFiydPqEq6cBB9JpPhkh6G8ZMBPIeZnkJlDWDFu8GR2ePTjKSnDO9jrdSImGVAUQ4vB28ZE3quDwBDSGAwDb6oAJs0dB8BhObSu8yUxiBXZv+BevJpX69g5YDeZkBG0EJqB20TJOTUuywAAAIEAxJLl/8GKF6LysfAv7VQH1nCmsTtYBWlUzlEJooiPPz6oHFC20kETM8nvxIG2bMhEOXI/bSqkiInGy2s3tDNcGkle7r1ROec0elyYp0eSvXHfrTPInBMjviY3IghyJg2+cL6t9C7Ieg4/SMJ0GFx34fCq8Vukek1QzDce/dc25IE=
"""
		let url = URL.Graph.getGraphURL()
		var request = URLRequest(url: url)
		request.httpBody = try? JSONEncoder().encode(self.body)
		request.httpMethod = "POST"
		request.setValue(token, forHTTPHeaderField: "token")
		request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		
		print(self.body)
		let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let data = data, error == nil else {
				print(error ?? "NetworkOperationError")
				self.resultBlock?(nil)
				return
			}
			do {
				print(String(data: data, encoding: String.Encoding.utf8) ?? "не удалось")

				let decoder = JSONDecoder()
				let formatter = DateFormatter()
				//"timestamp":"2019-12-01 17:00:00.000+0300",
				formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
				//formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
				decoder.dateDecodingStrategy = .formatted(formatter)
				//Получим данные
				let response = try decoder.decode(NetworkResponse.self, from: data)
				
				self.resultBlock?(response)
			}
			catch {
				print(error)
			}
		}
		dataTask.resume()
	}
}
