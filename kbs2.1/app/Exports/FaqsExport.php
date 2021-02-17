<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class FaqsExport implements FromCollection, WithHeadings,WithMapping
{
    /**
    * @return \Illuminate\Support\Collection
    */
    use Exportable;

    protected $faqDataCollection;

    public function __construct($query = null)
    {
        $this->faqDataCollection = $query;
    }

    public function map($faq) : array
    {
        return [
            $faq['id'],
            $faq['en_title'],
            $faq['en_body'],
            $faq['category_name'],
            $faq['author_name'],
            $faq['status'],
            $faq['tag'],
            $faq['publish_date'],
        ];
    }

    public function headings(): array
    {
        return [
            "ID",
            "Title",
            "Body",
            "Category Name",
            "Author Name",
            "Status",
            "Tag",
            "Publish At",
        ];
    }

    public function collection()
    {
        return $this->faqDataCollection;
    }
}
