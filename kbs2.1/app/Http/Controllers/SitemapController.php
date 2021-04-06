<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Models\Category;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\URL ;
use phpseclib3\Crypt\EC\Formats\Keys\XML;


class SitemapController extends Controller
{
    public function index(){
        $sitemap = App::make("sitemap");


        $sitemap->add(URL::to('category-list'), '2012-08-26T12:30:00+02:00', '2', 'daily');
        $sitemap->add(URL::to('category-article-list'), '2012-08-26T12:30:00+02:00', '2', 'daily');
        $sitemap->add(URL::to('article-list'), '2012-08-26T12:30:00+02:00', '2', 'daily');


        $articles =  Article::with('user','category','media','contents')->get();

        foreach ($articles as $article)
        {
            $sitemap->add(URL::to('article-details/{slug}'), $article->updated_at, $article->priority, $article->freq);
            $sitemap->add(URL::to('article/category/{slug}'), $article->updated_at, $article->priority, $article->freq);
            $sitemap->add(URL::to('article/search/{any}'), $article->updated_at, $article->priority, $article->freq);
        }

        $sitemap->store('xml', 'sitemap');

//        $xmlString = file_get_contents(public_path('sitemap.xml'));
//        $xmlObject = simplexml_load_string($xmlString);
//        $json = json_encode($xmlObject);
//        $phpArray = json_decode($json, true);
//        return $phpArray;

//        $xml = simplexml_load_file("sitemap.xml");
//        $json = json_encode($xml);
//        $array = json_decode($json,TRUE);
//        return $array;

        return redirect(\url('sitemap.xml'));
    }
}
