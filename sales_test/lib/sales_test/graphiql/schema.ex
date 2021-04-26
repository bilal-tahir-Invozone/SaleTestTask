defmodule TestGraphql.GraphQL.Schema do

  use Absinthe.Schema
  alias SalesTest.HandleDb




  query do
    @desc "provide data based on search(optional) sorted(optional) and pageNo(it is optional by default it is 1), it will return data
      EX:
      query{
        listMoviesApi ( sortedBy: 'asc'
        sortedItem: 'weighted_average_vote'  searchBy: '20,000 Leagues Under the Sea' pageNo: 1){
        count
        firstPage
        count
        hasNext
        hasPrev
        last
        list{
          avgRating
          director
          duration
          genre
          title
          totalVote
          year
        }
        nextPage
        prevPage
        page
        }
      }"
    field :list_movies_api, :somedata do
      arg :sorted_by, :string , default_value: " "
      arg :sorted_item, :string , default_value: " "
      arg :search_by, :string, default_value: " "
      arg :page_no, :integer , default_value: 1
      resolve fn _, %{page_no: page_no, sorted_by: sorted_by, search_by: search_by, sorted_item: sorted_item}, _ ->
        result = HandleDb.get_movie(sorted_by, search_by, sorted_item, page_no)
        {:ok, result}
      end
    end

    @desc "provide data based on pageNo(it is optional by default it is 1), it will return all data
      EX:
      query{
        moviesDetailApi(pageNo: 1){
          count
          firstPage
          count
          hasNext
          hasPrev
          last
          list{
            actors
            avgVote
            budget
            country
            datePublished
            description
            director
            duration
            genre
            language
            metascore
            originalTitle
            productionCompany
            reviewsFromCritics
            reviewsFromUsers
            title
            titleId
            usaGrossIncome
            votes
            worldwideGrossIncome
            writer
            year
            }
          nextPage
          prevPage
          page
        }"
    field :movies_detail_api, :ALLdata do
      arg :page_no, :integer , default_value: 1
      resolve fn _, %{page_no: page_no}, _ ->
        result = HandleDb.get_allmovie(page_no)
        {:ok, result}
      end
    end
  end

  object :ALLdata do
    field :count, :integer
    field :first_page, :integer
    field :has_next, :boolean
    field :has_prev, :boolean
    field :last, :integer
    field :list, list_of(:movie_detail)
    field :next_page, :integer
    field :page, :integer
    field :prev_page, :integer
  end

  object :somedata do
    field :count, :integer
    field :first_page, :integer
    field :has_next, :boolean
    field :has_prev, :boolean
    field :last, :integer
    field :list, list_of(:movie)
    field :next_page, :integer
    field :page, :integer
    field :prev_page, :integer
  end

  object :movie_detail do
    field :title, :string
    field :actors, :string
    field :avg_vote, :string
    field :budget, :string
    field :country, :string
    field :date_published, :string
    field :description, :string




    field :language, :string
    field :metascore, :string
    field :original_title, :string
    field :production_company, :string

    field :reviews_from_critics, :string
    field :reviews_from_users, :string

    field :title_id, :string

    field :usa_gross_income, :string
    field :votes, :string
    field :worldwide_gross_income, :string
    field :writer, :string

    field :year, :string
    field :genre, :string
    field :duration, :string
    field :director, :string

   end


   object :movie do
    field :title, :string
    field :avg_rating, :string
    field :year, :string
    field :genre, :string
    field :duration, :string
    field :director, :string
    field :total_vote, :string


   end











  # alias CommentGraphql.Client


  # object :result do
  #   field :success, :boolean
  # end

  # object :get_comments do

  #   field :id, :string
  #   field :comments, :string
  #   field :isdeletedbyadmin, :boolean
  #   field :likecount, :integer
  #   field :postid, :string
  #   field :replyid, :string
  #   field :status, :integer
  #   field :userid, :string
  #   field :userlikes, :integer
  #   field :medias, list_of(:media)

  # end

  # object :media do
  #   field :media_url, :string
  # end

  # object :get_replies do

  #   field :commentid, :string
  #   field :reply, :string
  #   field :isdeletedbyadmin, :boolean
  #   field :likecount, :integer
  #   field :postid, :string
  #   field :id, :string
  #   field :status, :integer
  #   field :userid, :string
  #   field :userlikes, :integer
  #   field :medias, list_of(:media)


  # end

  # query do
  #   field :get_comments, list_of(:get_comments) do
  #     resolve fn(_arg, _context) ->
  #       comments = "nothing is here"
  #       {:ok, comments}
  #     end
  #   end
  # end

  # mutation do

  #   @desc "provide reply, replyid, commentid, postid, isdeletedbyadmin, likecount, status, userlikes, mediaUrl  and userid then it will return boolean value True for success (updated) false for fail to update
  #   EX:
  #   mutation{
  #     updateReply(
  #       commentid:'90cb54c7-fc1e-46dc-86be-9211d1b4fb36'
  #       isdeletedbyadmin: true
  #       likecount:2
  #       postid:'90cb54c7-fc1e-46dc-86be-9211d1b4fb36'
  #       reply: 'yes it is right'
  #       replyid:'90cb54c7-fc1e-46dc-86be-9211d1b4fb36'
  #       status: 2
  #       userid: '90cb54c7-fc1e-46dc-86be-9211d1b4fb36'
  #       userlikes:1
  #       mediaUrl: ''

  #     )
  #     {
  #       success
  #     }
  #   }"

  #   field :update_reply, :result do

  #     arg :reply, non_null(:string)
  #     arg :isdeletedbyadmin, :boolean, default_value: false
  #     arg :userid, non_null(:string)
  #     arg :id, non_null(:string)
  #     arg :postid, non_null(:string)
  #     arg :status, :integer, default_value: 0
  #     arg :likecount, :integer, default_value: 0
  #     arg :userlikes, :integer, default_value: 0
  #     arg :commentid, non_null(:string)
  #     arg :media_url, :string, default_value: " "


  #     resolve fn(%{reply: reply, isdeletedbyadmin: isdeletedbyadmin, userid: userid, id: id, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url}, _context) ->

  #       reply_update = CommentGraphql.Client.update_reply(reply, isdeletedbyadmin, userid, id, postid, status, userlikes, likecount, commentid, media_url)
  #       case reply_update do
  #         {:ok, _} ->
  #           {:ok, %{success: true}}
  #         {:error , _} ->
  #           {:ok, %{success: false}}
  #       end
  #     end
  #   end

  #   @desc "provide reply, commentid, postid, isdeletedbyadmin, likecount, status, userlikes, mediaUrl  and userid then it will return boolean value True for success(created) false for fail to create
  #   EX:
  #   mutation{
  #     createReply(
  #       commentid:'90cb54c7-fc1e-46dc-86be-9211d1b4fb36'
  #       isdeletedbyadmin: false
  #       likecount: 1
  #       postid: '90cb54c7-fc1e-46dc-86be-9211d1b4fb36'
  #       reply: 'test'
  #       status:1
  #       userid:'90cb54c7-fc1e-46dc-86be-9211d1b4fb36'
  #       userlikes:1
  #       mediaUrl: ''

  #     )
  #     {
  #       success
  #     }
  #   }"


  #   field :create_reply, :result do

  #     arg :isdeletedbyadmin, :boolean, default_value: false
  #     arg :userid, non_null(:string)
  #     arg :reply, non_null(:string)
  #     arg :postid, non_null(:string)
  #     arg :status, :integer, default_value: 0
  #     arg :likecount, :integer, default_value: 0
  #     arg :userlikes, :integer, default_value: 0
  #     arg :commentid, non_null(:string)
  #     arg :media_url, :string, default_value: " "

  #     resolve fn(%{isdeletedbyadmin: isdeletedbyadmin, userid: userid, reply: reply,  postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url}, _context) ->

  #       replys = CommentGraphql.Client.create_reply(reply, isdeletedbyadmin, userid, postid, status, userlikes, likecount, commentid, media_url)
  #       case replys do
  #         {:ok, _} ->
  #           {:ok, %{success: true}}
  #         {:error , _} ->
  #           {:ok, %{success: false}}
  #       end
  #     end
  #   end

  #   @desc "provide  replyid, it will return all data
  #   EX:
  #   mutation{
  #     getReplyId(replyid: '3de78e38-2b33-4218-b741-3f599dbb50c1')
  #     {
  #       commentid
  #       reply
  #       isdeletedbyadmin
  #       likecount
  #       postid
  #       replyid
  #       status
  #       userid
  #       userlikes
  #       mediaUrl
  #     }
  #   }"

  #   field :get_repy_id, list_of(:get_replies) do
  #     arg :commentid, non_null(:string)

  #     resolve fn(%{commentid: commentid}, _context) ->

  #       data = CommentGraphql.Client.get_reply(commentid)
  #       {:ok, data}

  #     end
  #   end

  #   @desc "provide  id, it will return boolean value True for deleted false for fail to delete
  #   EX:
  #   mutation
  #   {
  #     deleteReply(id:'71237f14-d8a0-4e19-b00e-a391e8433159'){
  #       success
  #     }
  #   }"

  #   field :delete_reply, :result do
  #     arg :id, non_null(:string)

  #     resolve fn(%{id: id}, _context) ->

  #       delete_replyid = CommentGraphql.Client.delete_reply(id)
  #       case delete_replyid do
  #         {:ok, true} ->
  #           {:ok, %{success: true}}
  #         {:ok, false} ->
  #           {:ok, %{success: false}}
  #       end
  #     end
  #   end

  #   @desc "provide comment, commentid, postid, isdeletedbyadmin, likecount, status, userlikes, mediaUrl  and userid then it will return boolean value True for success (updated) false for fail to update
  #   EX:
  #   mutation{
  #     updateComment(
  #       comments: 'new test',
  #       commentid: '3de78e38-2b33-4218-b741-3f599dbb50c1'
  #       isdeletedbyadmin: false
  #       likecount: 1
  #       postid: '3de78e38-2b33-4218-b741-3f599dbb50c1'
  #       status: 1
  #       userid: '3de78e38-2b33-4218-b741-3f599dbb50c1'
  #       userlikes: 5
  #       mediaUrl: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+P+/HgAFhAJ/wlseKgAAAABJRU5ErkJggg=='
  #     )
  #     {
  #       success
  #     }
  #   }"


  #   field :update_comment, :result do

  #     arg :comments, non_null(:string)
  #     arg :isdeletedbyadmin, :boolean, default_value: false
  #     arg :userid, non_null(:string)
  #     arg :replyid, :string, default_value: " "
  #     arg :postid, non_null(:string)
  #     arg :status, :integer, default_value: 0
  #     arg :likecount, :integer, default_value: 0
  #     arg :userlikes, :integer, default_value: 0
  #     arg :id, :string
  #     arg :media_url, :string, default_value: " "

  #     resolve fn(%{comments: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, id: commentid, media_url: media_url}, _context) ->

  #       comment_update = CommentGraphql.Client.update_comment(comment, isdeletedbyadmin, userid, postid, status, userlikes, likecount, commentid, media_url)
  #       case comment_update do
  #         {:ok, _} ->
  #           {:ok, %{success: true}}
  #         {:error , _} ->
  #           {:ok, %{success: false}}
  #       end
  #     end
  #   end

  #   @desc "provide  commentid, it will return boolean value True for deleted false for fail to delete
  #   EX:
  #   mutation{
  #     deleteComment(commentid: '3de78e38-2b33-4218-b741-3f599dbb50c1'){
  #       success
  #     }
  #   }"


  #   field :delete_comment, :result do
  #     arg :commentid, non_null(:string)

  #     resolve fn(%{commentid: commentid}, _context) ->

  #       delete_comment = CommentGraphql.Client.delete_comment(commentid)
  #       case delete_comment do
  #         {:ok, true} ->
  #           {:ok, %{success: true}}
  #         {:ok, false} ->
  #           {:ok, %{success: false}}
  #       end
  #     end
  #   end

  #   @desc "provide postid  ,it will return all data
  #   EX:
  #   mutation{
  #     getCommentsId(postid: '3de78e38-2b33-4218-b741-3f599dbb50c1')
  #     {
  #       commentid
  #       comments
  #       isdeletedbyadmin
  #       likecount
  #       postid
  #       replyid
  #       status
  #       userid
  #       userlikes
  #       mediaUrl
  #     }
  #   }"


  #   field :get_comments_id, list_of(:get_comments) do
  #     arg :postid, non_null(:string)

  #     resolve fn(%{postid: postid}, _context) ->

  #       data = CommentGraphql.Client.get_comment(postid)
  #       IO.inspect data
  #       {:ok, data}

  #     end
  #   end

  #   @desc "provide comment, commentid, postid, isdeletedbyadmin, likecount, status, userlikes, mediaUrl  and userid then it will return boolean value True for success false for fail
  #   EX:
  #   mutation{
  #     createComment(
  #       comments: 'saem',
  #       isdeletedbyadmin: false
  #       likecount: 1
  #       postid: '3de78e38-2b33-4218-b741-3f599dbb50c1'
  #       status: 1
  #       userid: '4218-2b33-3de78e38-b741-3f599dbb50c1'
  #       userlikes: 5
  #       mediaUrl: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+P+/HgAFhAJ/wlseKgAAAABJRU5ErkJggg=='
  #     ) {
  #       success
  #     }
  #   }"


  #   field :create_comment, :result do

  #     arg :comments, non_null(:string)
  #     arg :isdeletedbyadmin, :boolean, default_value: false
  #     arg :userid, non_null(:string)
  #     arg :postid, non_null(:string)
  #     arg :status, :integer, default_value: 0
  #     arg :likecount, :integer, default_value: 0
  #     arg :userlikes, :integer, default_value: 0
  #     arg :media_url, :string, default_value: " "
  #     # arg :reply_id, :string, default_value: "empty"

  #     resolve fn(%{comments: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid,  postid: postid, status: status, userlikes: userlikes, likecount: likecount, media_url: media_url}, _context) ->

  #       comment = CommentGraphql.Client.create_comment(comment, isdeletedbyadmin, userid, postid, status, userlikes, likecount, media_url)
  #       case comment do
  #         {:ok, _} ->
  #           {:ok, %{success: true}}
  #         {:error , _} ->
  #           {:ok, %{success: false}}
  #       end
  #     end
  #   end
  # end
end
