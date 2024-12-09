//
//  ContentView.swift
//  weather
//
//  Created by 김원태 on 12/4/24.
//

import SwiftUI
import Alamofire

// JSON 응답 데이터를 디코딩할 구조체 정의
struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
}

struct ContentView: View {
    @State private var postTitle: String = "Loading..."
    @State private var postBody: String = "Loading Body..."

    var body: some View {
        VStack {
            Text("Post Title:")
                .font(.headline)
            Text(postTitle)
                .padding()
            Text("Post Body:")
                .font(.body)
            Text(postBody)
                .padding()
            Button(action: {
                fetchPost(postId:2)
            }, label: {
                Text("get post number 2")
            })
            Button(action: {
                fetchPost(postId:3)
            }, label: {
                Text("get post number 3")
            })
        }
        .onAppear {
            fetchPost(postId:1)
        }
    }

    func fetchPost(postId:Int) {
        let url = "https://jsonplaceholder.typicode.com/posts/\(postId)"
        // Alamofire GET 요청
        AF.request(url)
            .validate() // 응답 코드와 데이터 확인https://jsonplaceholder.typicode.com/posts/1
            .responseDecodable(of: Post.self) { response in
                switch response.result {
                case .success(let post):
                    // 요청 성공 시 데이터 표시
                    postTitle = post.title
                    postBody = post.body
                case .failure(let error):
                    // 요청 실패 시 에러 메시지 표시
                    postTitle = "Error: \(error.localizedDescription)"
                }
            }
    }
}

#Preview {
    ContentView()
        .previewLayout(.sizeThatFits) // 콘텐츠에 맞는 크기
        .frame(width: 300, height: 600) // 원하는 크기 지정
}
