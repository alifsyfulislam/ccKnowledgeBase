<?php

namespace App\Http\Controllers;

use App\Models\Content;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ContentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'role_id' => 'required',
        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->errors()->all()
            ]);

        }

        $content = new Content();
        $content->id = $request->id;
        $content->article_id = $request->article_id;
        $content->en_body = $request->en_body;
        $content->bn_body = $request->bn_body!= null ? $request->bn_body : 'n/a';
        $content->role_id = $request->role_id;
        $content->save();

        return response()->json([
            'status_code' => 200,
            'messages'=>config('status.status_code.200')
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return Content::where('id', $id)->first();
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
//        return response()->json($request->all());
        $validator = Validator::make($request->all(),[
            'role_id' => 'required',
        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->errors()->all()
            ]);

        }

        $content = Content::find($request->id);
        $content->article_id = $request->article_id;
        $content->en_body = $request->en_body;
        $content->bn_body = $request->bn_body != null ? $request->bn_body : 'n/a';
        $content->role_id = $request->role_id;
        $content->save();

        return response()->json([
            'status_code' => 200,
            'messages'=>config('status.status_code.200')
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request)
    {
        $content = Content::find($request->id);
        if ($content){
            $content->delete();
        }else{
            return 'no content found';
        }
    }

    public function showArticleContent($id){
        $contents = Content::where('article_id', $id)->orderBy('created_at', 'desc')->get();
        if ($contents){
            return $contents;
        }else{
            return 'no content found';
        }
    }

    public function checkArticleAvailability($id){
        $contents = Content::where('article_id', $id)->orderBy('created_at', 'desc')->get();
        if ($contents){
            foreach ($contents as $content){
                $content->delete();
            }
        }else{
            return 'no article found';
        }
    }
}
