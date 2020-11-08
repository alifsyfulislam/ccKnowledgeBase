<?php


namespace App\Services;


use App\Helpers\Helper;
use App\Repositories\ArticleRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class ArticleService
{
    /**
     * @var ArticleRepository
     */
    protected $articleRepository;

    public function __construct(ArticleRepository $articleRepository)
    {

        $this->articleRepository = $articleRepository;

    }


    /**
     * @return JsonResponse
     */
    public function getAll()
    {

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'article_list'=>$this->articleRepository->all()]);

    }


    /**
     * @return JsonResponse
     */
    public function paginateData()
    {

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'article_list'=>$this->articleRepository->getWithPagination()]);

    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function createItem(Request $request)
    {

        $thumbFile = [];

        $validator = Validator::make($request->all(),[

            'en_title' => 'required|string',


        ]);

        if($validator->fails()) {

            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);

        }

        if(isset($request->image_file)) {

            $thumbImageList = $request->image_file;
            $countImage = count($thumbImageList);

            for ($i = 1; $i <= $countImage; $i++) {

                if($countImage > 0) {

                    $thumbFile[] = Helper::base64ImageUpload("article/images", $thumbImageList[$countImage-1]);

                }

            }
        }

        $input = $request->all();
        $input['id'] = time().rand(1000,9000);


        DB::beginTransaction();

        try {

            $this->articleRepository->create($input);
            $article = $this->getItemById($input['id']);

            foreach ($thumbFile as $image):

                $article->media()->create([

                    'url' => $image

                ]);

            endforeach;

        } catch (Exception $e) {

            DB::rollBack();
            Log::info($e->getMessage());

            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);
        }

        DB::commit();

        return response()->json(['status_code' => 201, 'messages'=>config('status.status_code.201')]);

    }


    public function getItemById($id)
    {

        return $this->articleRepository->get($id);
    }

}
